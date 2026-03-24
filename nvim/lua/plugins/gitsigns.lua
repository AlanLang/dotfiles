return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
      virt_text_pos = "eol",
    },
    current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> · <summary>",
    on_attach = function(bufnr)
      -- 将 git remote URL 转换为 web commit URL
      local function remote_to_commit_url(remote, hash)
        remote = remote:gsub("%s+$", "")

        -- Bitbucket Server: ssh://git@code.fineres.com:7999/PROJECT/repo.git
        local project, repo = remote:match("ssh://[^/]+/([^/]+)/([^/]+)%.git$")
        if project and repo then
          return string.format("https://code.fineres.com/projects/%s/repos/%s/commits/%s", project, repo, hash)
        end

        -- Bitbucket Server HTTPS: https://code.fineres.com/scm/PROJECT/repo.git
        project, repo = remote:match("https://code%.fineres%.com/scm/([^/]+)/([^/]+)%.?g?i?t?$")
        if project and repo then
          return string.format("https://code.fineres.com/projects/%s/repos/%s/commits/%s", project, repo, hash)
        end

        -- GitHub/GitLab SSH: git@github.com:user/repo.git
        local host, path = remote:match("^git@(.-):(.*)")
        if host and path then
          path = path:gsub("%.git$", "")
          return string.format("https://%s/%s/commit/%s", host, path, hash)
        end

        -- GitHub/GitLab HTTPS: https://github.com/user/repo.git
        local url = remote:gsub("%.git$", "")
        if url:match("^https://") then
          return url .. "/commit/" .. hash
        end

        return nil
      end

      vim.keymap.set("n", "<leader>go", function()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local file = vim.api.nvim_buf_get_name(bufnr)

        local hash = vim.fn.system(
          string.format("git blame -L %d,%d --porcelain %s 2>/dev/null | head -1", row, row, vim.fn.shellescape(file))
        ):match("^(%x+)")

        if not hash or hash:match("^0+$") then
          vim.notify("当前行尚未提交", vim.log.levels.WARN)
          return
        end

        local remote = vim.fn.system("git remote get-url origin 2>/dev/null")
        if remote == "" then
          vim.notify("找不到 git remote origin", vim.log.levels.WARN)
          return
        end

        local url = remote_to_commit_url(remote, hash)
        if not url then
          vim.notify("无法识别的 remote URL: " .. remote, vim.log.levels.WARN)
          return
        end

        vim.fn.jobstart({ "open", url })
        vim.notify("打开：" .. url)
      end, { buffer = bufnr, desc = "Git: 在浏览器打开当前行 commit" })
    end,
  },
}
