FROM python:3.8.3-alpine3.10

LABEL maintainer="Mritunjay Sharma" <mritunjaysharma394@Qgmail.com>
LABEL repository="https://github.com/mritunjaysharma394/autoyapf"
LABEL homepage="https://github.com/mritunjaysharma394/autoyapf"

LABEL com.github.actions.name="autoyapf"
LABEL com.github.actions.description="Automating Python formatting using yapf"
LABEL com.github.actions.icon="code"
LABEL com.github.actions.color="blue"


COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]