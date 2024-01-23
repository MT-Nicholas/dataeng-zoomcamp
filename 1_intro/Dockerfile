# every Dockerfile starts with the base Docker image that we will build on
FROM python:3.9.1

# set up our image by installing prerequisite environment configurations; pandas in this case
RUN pip install pandas

# set up the working directory inside the container (standard procedure)
WORKDIR /app
# copy the script to the container: 1st name is source file, 2nd is destination (not sure about this)
COPY pipeline.py pipeline.py

# define what to do first when the container runs
# in this example, we will just run the script
# i.e. we are 'automating' the terminal input of "python", "pipeline.py"
ENTRYPOINT ["python pipeline.py"]