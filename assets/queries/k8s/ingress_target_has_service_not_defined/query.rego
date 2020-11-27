package Cx

CxPolicy [ result ] {

  resourceKind := input.document[i].kind
  
  resourceIngress := input.document[i].spec.rules[name].http.paths[path]
  
  IsIngress(resourceKind) ;
  not CheckIngressService(resourceIngress) 

  
  result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("spec.rules[%d].http.paths[%d].backend.service", [name, path]),
                "issueType":		  "MissingAttribute",
                "keyExpectedValue": sprintf("spec.rules[%d].http.paths[%d] is defined ", [name, path]),
                "keyActualValue": 	sprintf("spec.rules[%d].http.paths[%d] is undefined ", [name, path])
            }
}


IsIngress(resourceKind) = true {
	resourceKind == "Ingress"
}

CheckIngressService(resourceIngress) = true {
	resourceIngress.backend.service.name != null; 
    resourceIngress.backend.service.port.number != null;
    resourceIngress.backend.service.port.number > 0
}