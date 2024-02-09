const pool = require("../queries/db.js");

const cuisineNormalisation = async (cuisineString) => {
    const { rows } = await pool.query("SELECT r.*, c.name cuisine_name FROM cuisines c JOIN restaraunts r ON c.id = r.cuisine_id where c.name=$1;", [cuisineString]);
    return rows;
}

const getRecs = async (req, res) => {

    const { prefferedCuisines } = req.body;

    let recs = [];
    for (let i = 0; i < prefferedCuisines.length; i++) {
        recs = [
            ...recs,
            ...(await cuisineNormalisation(prefferedCuisines[i]))
        ];
    }

    return res.status(200).send(recs);
};

module.exports = {
    getRecs
};
