# ckanext-upload_via_email

Upload packages to CKAN via Email

Minimal supported CKAN version: 2.8.1

## Installation

* Install [ckanext-datapackage_pipelines](https://github.com/OriHoch/ckanext-datapackage_pipelines) extension
* Install the ckanext-upload_via_email package into your CKAN virtual environment:
  * `pip install ckanext-upload_via_email`
* Add ``upload_via_email`` to the ``ckan.plugins`` setting in your CKAN
* Restart CKAN
* Restart the CKAN pipelines server

## Configuration

* Generate a Gmail API credentials file
  * See [here](https://developers.google.com/gmail/api/quickstart/python)
* Generate a Gmail API token file, authorize with the Gmail user which will receive the emails
  * `sudo pip3 install -r pipelines/requirements.txt`
  * `CREDENTIALS=/path/to/credentials_file bin/generate_ckan_config.py`
* Add the output config to your CKAN configuration (be sure to keep it secret)
* Add the following configurations as well:
```
ckanext.upload_via_email.allowed_senders_resource_id = ckan_resource_id_containing_allowed_senders_file
ckanext.upload_via_email.success_message = The dataset is available at {dataset_url}
ckanext.upload_via_email.success_message_from_email = do-not-reply@void.void
ckanext.upload_via_email.success_message_subject = Your dataset was created successfully
```

## Allowed senders file

The allowed senders file should be uploaded to CKAN as a private dataset with only 1 resource.
The resource should contain an xlsx file with the following columns:

* **from_address**: email address sender is allowed to send from
* **to_address**: email address sender is allowed to send to
* **organization_id**: id of sender's organization

## Updating the package on PYPI

Update the version in `VERSION.txt`, then build and upload:

```
python setup.py sdist &&\
twine upload dist/ckanext-upload_via_email-$(cat VERSION.txt).tar.gz
```

ckanext-upload_via_email should be availabe on PyPI as https://pypi.python.org/pypi/ckanext-upload_via_email.

## Developing the pipelines

The pipelines are defined in [pipelines/pipeline-spec.yaml](pipelines/pipeline-spec.yaml) using the [datapackage-pipelines](https://github.com/frictionlessdata/datapackage-pipelines) framework. All `.py` files under the `pipelines` directory run on the CKAN pipelines server which uses Python 3.6.

* Start the CKAN server
* Start a Python 3.6 virtualenv
  * `pipenv shell`
* Clone the ckanext-datapackage_pipelines and install the requirements
  * `pip install -Ur ../ckanext-datapackage_pipelines/datapackage_pipelines_ckanext/requirements.txt`
  * `pip install -e ../ckanext-datapackage_pipelines/datapackage_pipelines_ckanext`
* Install the upload via email requirements
  * `pip install -r pipelines/requirements.txt`
* Change to the pipelines directory and run dpp
  * `cd pipelines`
  * `dpp`