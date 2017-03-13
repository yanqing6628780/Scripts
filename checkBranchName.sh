#!/bin/bash
#
# Copyright 2017-2017 PandoraBox-Team All rights reserved
#
# Last Update 2017-02-13
#
BRANCH_NAME=$1

#######################################
#
# 输出Copyright 信息
#
#######################################
f_copyright()
{
cat -s <<- EOF

> Copyright 2017-2017 PandoraBox-Team All rights reserved
> Last Update 2017-02-13
EOF
}

#######################################
#
# 错误时输出的信息
#
#######################################
f_errormsg()
{
[[ -z $gitlabMergeRequestId ]] || _GITLAB_TITLE_EMOJI=':negative_squared_cross_mark:'

[[ -z $gitlabUserName ]] || _GITLAB_PING_USER='> Ping @${gitlabUserName}'

echo "\
# ${_GITLAB_TITLE_EMOJI:-} 分支名( ${BRANCH_NAME} )无效

请参考下表

## 分支名命名规则
"'
| 有效分支名   | 对应意思       | 对应用法                              |
| ------------ | -------------- | ------------------------------------- |
| `feature/*`  | 功能分支       | 对应新添加的业务需求或者新特性        |
| `bugfix/*`   | 常规修复分支   | 正常修复Bug时所使用的分支             |
| `hotfix/*`   | 紧急修复分支   | 紧急修复Bug时所使用的分支             |
| `issus/*`    | Bug修复分支    | 修复Issus上的问题, 一般加上Issus ID   |
| `jira/*`     | Bug修复分支    | 修复Jira上的问题, 一般加上Jira  ID    |
| `release/*`  | 发布分支       | 发布版本用的分支                      |
| `patch/*`    | 补丁          | 补丁                                 |
'"
${_GITLAB_PING_USER:-}"
}

[[ -z "$BRANCH_NAME" ]] && {

echo "Usage: $0 [BranchName]"
f_copyright

exit 1
}

OUTPUT_FILE='branchname.output'
[[ $BRANCH_NAME =~ ^(feature|hotfix|bugfix|issus|jira|release|patch)[-/][a-zA-Z0-9] ]] || {
  f_errormsg  | tee ${OUTPUT_FILE}
  f_copyright | tee -a ${OUTPUT_FILE}
  exit 1
}
