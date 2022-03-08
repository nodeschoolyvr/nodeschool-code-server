FROM codercom/code-server:4.1.0

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN sudo apt-get update && sudo apt-get install build-essential python nodejs -y

# use custom scraper to get the list of all the nodeschool modules listed on nodeschool.io 
COPY scrape.js package.json ./
RUN npm install && sudo -E npm install -g $(node scrape https://nodeschool.io)

# Clean up
RUN sudo apt-get remove build-essential python -y
RUN rm scrape.js node_modules package*.json -r
