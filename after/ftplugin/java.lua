local jvm_args = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Xmx6G -Xms1G "

local lombok_jars = vim.fn.glob(vim.fs.normalize("~/.local/share/jdtls/*/lombok.jar"), false, true)
local lombok_jar = lombok_jars[#lombok_jars]

if lombok_jar and vim.fn.filereadable(lombok_jar) == 1 then
  vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. lombok_jar .. " " .. jvm_args
else
  vim.notify("jdtls: lombok.jar not found, starting without -javaagent", vim.log.levels.INFO)
  vim.env.JDTLS_JVM_ARGS = jvm_args
end
