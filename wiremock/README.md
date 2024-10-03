# wire-mock

This is a custom build of [wiremock](https://wiremock.org/docs/overview/) to allow the locale to be set to en_ZA to generate fake data
from South Africa. A image from this build has been pushed to docker.io as imqs/wiremock:latest, this is just for posterity of how it was built.

The reason for the custom build is that there are two pull-request on [wiremock-faker](https://github.com/wiremock/wiremock-faker-extension)
that is needed for the change in locale.

An example of usage is available in config qa-mm/clientconfs/ImqsMaintenanceManagement/1/mocking on the branch ll-asg-3723-crm-integration-changes.
