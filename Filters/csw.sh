curl -X POST "http://openapi.aurin.org.au/csw?service=CSW&request=GetRecords&typeNames=csw:Record" --user "student:dj78dfGF" --header "Content-Type:application/xml" --data @${1}
