package Cx

SupportedResources = "$.resource ? (@.aws_security_group_rule != null || @.aws_security_group != null"

CxPolicy [ result ] {
	rule := input.document[i].resource.aws_security_group_rule[name]
    rule.type == "ingress"
    rule.from_port
    rule.to_port
    contains(rule.cidr_blocks[_], "0.0.0.0/0")

    result := {
                "foundKye": 		rule,
                "fileId": 			input.document[i].id,
                "fileName": 	    input.document[i].file,
                "lineSearchKey": 	[concat("+", ["aws_security_group_rule", name]), "ingress"],
                "issueType":		"MissingAttribute",
                "keyName":			"protocol",
                "keyExpectedValue": 8,
                "keyActualValue": 	null,
                #{metadata}
              }
}

CxPolicy [ result ] {
	ingrs := input.document[i].resource.aws_security_group[name].ingress
    ingrs.from_port
    ingrs.to_port
    contains(ingrs.cidr_blocks[_], "0.0.0.0/0")

    result := {
                "foundKye": 		ingrs,
                "fileId": 			input.document[i].id,
                "fileName": 	    input.document[i].file,
                "lineSearchKey": 	[concat("+", ["aws_security_group", name]), "ingress"],
                "issueType":		"MissingAttribute",
                "keyName":			"protocol",
                "keyExpectedValue": 8,
                "keyActualValue": 	null,
                #{metadata}
              }
}
