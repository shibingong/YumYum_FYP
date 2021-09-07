const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => { 
    res.json("YumYum Server Site");
});

app.listen(port, () => {
    console.log(`Now listening on port ${port} at http://localhost:${port}`); 
});