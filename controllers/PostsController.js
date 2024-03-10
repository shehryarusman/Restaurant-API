// CRUD operations for posts
const pool = require('../queries/db');
const queryDB = require('../queries/queryDB');
const uploadImages = require('../aws/uploadImages');
const deleteImages = require('../queries/deleters/deleteImages');

const createPost = async (req, res) => {
    const { review, dish: dishName, restaurant: restaurantName } = req.body;
    const { files } = req;

    // Confirm that review isn't empty
    if (!review) return res.status(400).send('Must provide review body');
    if (!dishName) return res.status(400).send('Must provide dish name');
    if (!restaurantName) return res.status(400).send('Must provide restaurant name');

    // Create the dish if it doesn't exist
    let { rows: [dish] } = await pool.query("SELECT * FROM dishes WHERE name = $1", [dishName]);
    if(!dish){
        await pool.query("INSERT INTO dishes (name) VALUES ($1)", [dishName]);
        dish = (await pool.query("SELECT * FROM dishes WHERE name = $1", [dishName])).rows[0];
    }

    // Create the restaurant if it doesn't exist
    let { rows: [restaurant] } = await pool.query("SELECT * FROM restaurants WHERE name = $1", [restaurantName]);
    if(!restaurant){
        await pool.query("INSERT INTO restaurants (name) VALUES ($1)", [restaurantName]);
        restaurant = (await pool.query("SELECT * FROM restaurants WHERE name = $1", [restaurantName])).rows[0];
    }

    // Create the new post
    const { rows: [newPost] } = await pool.query(
        "INSERT INTO posts (review, author_id, dish_id, restaurant_id) VALUES ($1, $2, $3, $4) RETURNING *",
        [review, req.user.id, dish.id, restaurant.id]
    );

    // Store the posts's images on AWS, and store keys to the database
    await uploadImages(files, newPost);

    return res.status(201).send('Post created');
}

const updatePost = async (req, res) => {
    const { id: postId } = req.params;
    const { review } = req.body;
    
    // Files represent the new post images
    const {
        files
    } = req;

    // Confirm that review isn't empty
    if (!review) return res.status(400).send('Must provide review body');

    // Check that the post exists in the database
    const [ post ] = await queryDB('posts', 'get', { where: ['id'] }, [postId]);
    if (!post) return res.status(404).send('Post not found');

    // Make sure that it's the user's own post that their deleting
    if (post.author_id !== req.user.id) return res.status(403).send('You can only update your own posts');

    // Update the post review
    await queryDB('posts', 'put', { params: ['review'], where: ['id'] }, [review, postId]);

    // Remove all the old images from the post
    await deleteImages(postId);

    // Upload new images to AWS & store keys to the database associated with this post
    await uploadImages(files, post);

    return res.status(200).send('Post updated');
}

module.exports = {
    createPost,
    updatePost,
};