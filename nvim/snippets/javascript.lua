return {
  {
    prefix = "cons",
    desc = "Quick Console Log w/ variable",
    body = "console.log('${TM_SELECTED_TEXT}$1: ', $TM_SELECTED_TEXT$1);$0",
  },
  {
    prefix = "conj",
    desc = "Console Log JSON stringified variable",
    body = "console.log('${TM_SELECTED_TEXT}$1: ', JSON.stringify($TM_SELECTED_TEXT$1, null, 2));$0",
  },
  {
    prefix = "log",
    desc = "Quick Console Log",
    body = "console.log('$1');$0",
  },
  {
    prefix = "func",
    desc = "Basic Function Block",
    body = {
      "function ${1:functionName}(${2:params}) {",
      "    $3",
      "}$0",
    },
  },
  {
    prefix = "then",
    desc = "Basic Then block",
    body = {
      ".then((${1:result}) => {",
      "    $2",
      "})$0",
    },
  },
  {
    prefix = "catch",
    desc = "Basic catch block",
    body = {
      ".catch((err) => {",
      "    ${1:console.error(err)}",
      "});$0",
    },
  },
  {
    prefix = "fin",
    desc = "Basic Finally block",
    body = {
      ".finally(() => {",
      "    $1",
      "})$0",
    },
  },
  {
    prefix = "wfunc",
    desc = "Wrap inside function",
    body = {
      "function ${1:functionName}() {",
      "    ${TM_SELECTED_TEXT}",
      "}$0",
    },
  },
}
