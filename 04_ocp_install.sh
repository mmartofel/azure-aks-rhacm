
# at my laptop I must to remove the osServicePrincipal.json file first to get rid of the old subscription connection
rm /Users/mmartofe/.azure/osServicePrincipal.json

./openshift-install create cluster --dir ./ocp-azure --log-level debug

