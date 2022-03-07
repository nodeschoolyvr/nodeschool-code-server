import got from "got";
import { load } from "cheerio";

// Some workshoppers don't install anymore or won't be useful
// inside a container, list which workshops not to install here.
let dontInstall = [
  "elementary-electron",
  "webgl-workshop",
  "introtowebgl",
  "learnuv",
  "perfschool",
  "levelmeup",
  "learn-sass",
  "nodebot-workshop"
]

let workshops = "";
// scrapes url and gets a list of workshoppers to install
// scrapes for <code>npm install -g TARGET</code>
// logs a list of TARGETs, to be installed with npm 
got.get(process.argv[2])
  .then(res => {
    let $ = load(res.body);
    $('code').each(function () {
      let ws = $(this).text().split("npm install -g ");
      if (ws.length > 1 && !(dontInstall.includes(ws[1]))) {
        workshops += ws[1] + " ";
      }
    })
    console.log(workshops);
  })
