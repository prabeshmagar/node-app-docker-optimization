import express from 'express';

const app = express();
const port = parseInt(process.env.SERVER_PORT || '3000', 10);
const service = process.argv[2] || 'default';

// Middleware to log requests
app.use((req, res, next) => {
    console.log(`Request to ${service} service at ${new Date().toISOString()}`);
    next();
});

// Define routes based on the service
app.get('/', (req, res) => {
    res.send(`Hello from ${service} service!`);
});

app.listen(port, '0.0.0.0', () => {
    console.log(`Service ${service} is running on port ${port}`);
});
