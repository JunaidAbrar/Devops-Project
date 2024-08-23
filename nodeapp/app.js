const express = require("express")
const app = express()

app.get("/", (req, res) => {
    res.send("It's working, lessgo");
});



app.listen(8080, () => {
  console.log("Server is up and running on port 8080")
})