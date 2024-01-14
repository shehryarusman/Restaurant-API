const httpServer = require('./app');
const { PORT } = require('@RestaurantApp-Api-api/constants');

httpServer.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

