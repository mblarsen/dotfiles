vim.filetype.add {
  filename = {
    ["terragrunt.hcl"] = "terragrunt",
  },
  pattern = {
    [".*%.hcl"] = "terragrunt",
    [".*terraform/.*%.hcl"] = "terragrunt",
  },
}
