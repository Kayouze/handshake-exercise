FROM python:3.9-slim

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

WORKDIR /app

COPY app.py /app

RUN pip install flask

RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]
