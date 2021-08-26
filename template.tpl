___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "RegEx Table",
  "description": "Match an Input Variable to the Patterns in the RegEx Table and return an Output Value when a match is found.",
  "categories": ["UTILITY"],
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "input",
    "displayName": "Input Variable",
    "macrosInSelect": true,
    "selectItems": [],
    "simpleValueType": true,
    "help": "The Input Variable will be matched against each Pattern in the RegEx Table below, from top to bottom. When a match is found, the Output value from that row will be returned.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "regexTable",
    "displayName": "RegEx Table",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Pattern",
        "name": "pattern",
        "type": "TEXT",
        "valueHint": "Enter valid pattern, there is no validation upon input."
      },
      {
        "defaultValue": "",
        "displayName": "Output",
        "name": "output",
        "type": "TEXT"
      }
    ],
    "help": "The Input Variable will be matched against each Pattern in the RegEx Table below, from top to bottom. When a match is found, the Output value from that row will be returned. Enter Patterns using Regular Expressions. By default, patterns may partially match the input string and are case sensitive. This behavior can be adjusted in Advanced Settings. Note that your Regular Expressions have to be valid when you enter them, as validation only takes place upon execution-- not when input is entered. When escaping a character, use a double backslash (e.g. \\\\.)"
  },
  {
    "type": "CHECKBOX",
    "name": "enableDefaultValue",
    "checkboxText": "Set Default Value",
    "simpleValueType": true,
    "help": "Explicitly set the value of this variable when no Patterns match."
  },
  {
    "type": "TEXT",
    "name": "defaultValue",
    "displayName": "Default Value",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "enableDefaultValue",
        "paramValue": true,
        "type": "EQUALS"
      }
    ],
    "help": "To set the value to be an empty string, leave the field blank."
  },
  {
    "type": "GROUP",
    "name": "advancedSettings",
    "displayName": "Advanced Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "lowerCase",
        "checkboxText": "Convert Case of Input Variable to Lowercase",
        "simpleValueType": true,
        "help": "Because case insensitive matching is unavailable, you can lowercase your input variable. In combination with a lowercase RegEx pattern, you can approach the traditional \"Ignore Case\" functionality."
      },
      {
        "type": "CHECKBOX",
        "name": "fullMatchesOnly",
        "checkboxText": "Full Matches Only",
        "simpleValueType": true,
        "help": "If enabled, patterns must match entire input. This is equivalent to having start (^) and end ($) anchors implicitly around your pattern. If disabled, patterns will match when they are found anywhere in the input."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const makeString = require('makeString');

const input = makeString(data.input);

let result,
    pattern,
    regexRule;

if(data.regexTable) {
  for (let i = 0; i < data.regexTable.length; i++) {
    regexRule = data.regexTable[i];
    pattern = data.fullMatchesOnly ? "^" + regexRule.pattern + "$" : regexRule.pattern;
    if ((data.lowerCase ? input.toLowerCase() : input ).match(pattern)) {
      return regexRule.output;
    }
  }
}

return data.enableDefaultValue && result == undefined ? data.defaultValue || "" : undefined;


___TESTS___

scenarios:
- name: Simple Match
  code: |-
    const mockData = {
      input: "input.",
      regexTable: [{'pattern':'^inp[a-z]t\\.', 'output':'success'}]
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
setup: ''


___NOTES___

Created on 26/08/2021, 10:08:24


