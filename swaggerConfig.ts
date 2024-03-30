import swaggerJsdoc from 'swagger-jsdoc';

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'NeloApp Backend',
      version: '1.0.0',
    }
  },
  apis: ['./src/routes/*.ts'],
};

const swaggerConfig = swaggerJsdoc(options);

export default swaggerConfig;