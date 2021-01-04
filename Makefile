start update:
	aws --region us-west-2 cloudformation update-stack \
		--stack-name minecraft \
		--template-body "`cat cf.yml`" \
		--parameters "`cat cf.json`" \
		--capabilities CAPABILITY_IAM
	aws --region us-west-2 cloudformation wait stack-update-complete \
		--stack-name minecraft

stop:
	cat cf.json  | sed -e 's/Running/Stopped/' > stopped.json
	aws --region us-west-2 cloudformation update-stack \
		--stack-name minecraft \
		--template-body "`cat cf.yml`" \
		--parameters "`cat stopped.json`" \
		--capabilities CAPABILITY_IAM
	aws --region us-west-2 cloudformation wait stack-update-complete \
		--stack-name minecraft

