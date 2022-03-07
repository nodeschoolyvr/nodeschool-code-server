FROM codercom/code-server:4.1.0


# install n, node, and npm
RUN sudo apt-get update && sudo apt-get install build-essential python -y
RUN curl -L https://git.io/n-install | bash -s -- -y

ENV PATH="${PATH}:/home/coder/n/bin"

# use custom scraper to get the list of all the nodeschool modules listed on nodeschool.io 
COPY scrape.js package.json ./
RUN npm install
RUN npm install -g $(node scrape https://nodeschool.io)

# Clean up
RUN sudo apt-get remove make -y
RUN rm scrape.js node_modules package*.json -r
