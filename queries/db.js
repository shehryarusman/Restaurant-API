const { Pool } = require('pg');

const pool = new Pool(process.env.NODE_ENV === 'production' ? {
    user: process.env.RDS_USERNAME,
    host: process.env.RDS_HOSTNAME,
    database: process.env.RDS_DB_NAME,
    password: process.env.RDS_PASSWORD,
    port: process.env.RDS_PORT,
} : {
    user: 'postgres',
    host: 'localhost',
<<<<<<< HEAD
    database: 'restaurantapp',
=======
    database: 'RestaurantApp',
>>>>>>> 92896d054d0f96aa71c30786a46b9a0f0854823e
    password: '',
    port: 5432,
});

module.exports = pool;