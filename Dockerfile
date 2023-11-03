# Use Python 3.9.18 as base image
FROM python:3.9.18-bullseye

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

ENV APP_HOME /app
ENV TZ=UTC

WORKDIR $APP_HOME

COPY . .

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Switch to the non-privileged user to run the application.
USER appuser

RUN sh setup.sh

CMD ["python3", "classify.py"]