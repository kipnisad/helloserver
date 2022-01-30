FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install --user -r requirements.txt

COPY . .

#CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
RUN useradd -u 8877 webuser
USER webuser

CMD ["gunicorn"  , "-b", "0.0.0.0:8000", "-w", "4", "app:app"]