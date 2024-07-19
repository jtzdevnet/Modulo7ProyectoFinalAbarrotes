import knex from 'knex';
import dotenv from 'dotenv';
import configFile from './knexfile.js';

dotenv.config();

const db = knex(configFile.development);

export default db;