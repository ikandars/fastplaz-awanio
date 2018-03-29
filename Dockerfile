# Use an official ubuntu as a parent image
# build:
#   docker build -t fastplaz-centos .
# enter bash:
#   docker run -it fastplaz-centos bash

FROM centos:7 AS base

MAINTAINER Luri Darmawan <luri@***.com>

# Initialize Directories and Files
#VOLUME ["/projects/vendors", "/public_html", "/app"]
RUN mkdir -p /projects/vendors/
WORKDIR /projects
ADD ./app/ /app
RUN rm -rf /app/fpc-3.0.2.x86_64-linux.tar
RUN rm -rf /app/fpc-install.sh

# Environment
ENV NAME FastPlaz
#ENV DISTRO FastPlaz-Centos


# Install any needed packages specified
RUN yum install -y httpd
#RUN yum install -y git 
#RUN yum install nano vim

# Apache setup
ADD config/apache/fastplaz.conf /etc/httpd/conf.d/
RUN ln -s /projects/echo/public_html /var/www/html/echo
RUN echo "FastPlaz for Docker" > /var/www/html/index.html


# Make port 80 available to the world outside this container
EXPOSE 80
EXPOSE 443



# ---- Dependencies ----
#FROM base AS dependencies

# Prepare FastPlaz
RUN /app/fastplaz-init-runtime.sh
RUN ln -s /app/centos-run.sh /app/run.sh
ADD ./project-examples/echo /projects/echo/
RUN chmod -R 777 /projects/echo/public_html/ztemp

# run apache
CMD ["/app/run.sh"]

