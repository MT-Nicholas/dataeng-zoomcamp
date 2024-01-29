# every Dockerfile starts with the base Docker image that we will build on
FROM python:3.9.1

# set up our image by installing prerequisite environment configurations; pandas in this case
# In most Linux distributions, 'wget' comes pre-installed. If it's not, you can install it by running the command `apt-get install wget`. We need this to download the .csv file
RUN apt-get install wget
# psycopg2 is a postgres db adapter for python: sqlalchemy needs it. It may be included with anaconda, but better to be sure this way.
RUN pip install pandas sqlalchemy psycopg2

# set up the working directory inside the container (standard procedure)
WORKDIR /app
# copy the script to the container: 1st name is source file, 2nd is destination (not sure about this)
COPY ingest_data.py ingest_data.py 

# define what to do first when the container runs
# in this example, we will just run the script
# i.e. we are 'automating' the terminal input of "python", "pipeline.py"
ENTRYPOINT [ "python", "ingest_data.py" ]