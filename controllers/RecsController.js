const pool = require("../queries/db.js");

const cuisineNormalisation = async (cuisineString) => {
    const { rows: dishes } = await pool.query(`
        SELECT
            d.id,
            d.name name,
            r.name restaurant_name
        FROM cuisines c
        JOIN restaurants r ON c.id = r.cuisine_id
        JOIN dishes d ON d.restaurant_id = r.id
        WHERE c.name=$1;
    `, [cuisineString]);
    return dishes;
}

const getRecs = async (req, res) => {

    const { preferredQuisines } = req.body;

    let recs = [];
    for (const quisine of preferredQuisines) {
        const dishes = await cuisineNormalisation(quisine);
        recs = [...recs, ...dishes];
    }

    return res.status(200).send(recs);
};

module.exports = {
    getRecs
};
