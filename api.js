import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import fetch from "node-fetch";
import db from './db.js';

dotenv.config();
const api = express();
api.use(express.json());
api.use(cors());

///////////// Products API //////////////////////////////
api.post('/api/products', async (req,res)=>{

    const { name, price, sku, descr } = req.body;

    if(!name || !price || !sku){
        return res.status(400).json({
            msg: 'Faltan datos'
        })
    }

    try {
        const newProduct = await db('products').insert({
            name: name,
            price: price,
            sku: sku,
            descr: descr
        }).returning('*')
        return res.status(201).json({
            msg: 'Producto creado',
            product: newProduct
        })
        
    } catch (error) {
        return res.status(500).json({
            msg: 'Error creando producto'
        })
    }

});

api.get('/api/products', async (req,res)=>{
    try {
        const products = await db.select('*').from('products');
        return res.status(200).json({
            msg: 'Todos los productos',
            products: products
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({msg: `Error obteniendo todos los productos`});
        
    }
});

api.get('/api/products/:product_id', async (req,res)=>{
    const { product_id } = req.params;
    try {
        const products = await db.select('*').from('products').where('product_id', product_id).first();
        return res.status(200).json({
            msg: 'Producto encontrado',
            products: products
        });
    } catch (error) {
        return res.status(500).json({msg: `Error obteniendo el producto: ${product_id}`});
    }
});

api.put('/api/products/:product_id', async (req,res)=>{
    const { product_id } = req.params;
    const { name, price, sku, descr } = req.body;

    try {
        const updated = await db('products').update({
            name: name,
            price: price,
            sku: sku,
            descr: descr
        }).where({
            product_id: product_id
        })
        .returning('*');
        return res.status(200).json({
            msg: 'Producto actualizado',
            products: updated[0]
        });
    } catch (error) {
        return res.status(500).json({msg: `Error obteniendo el producto ${product_id}`});
    }
});

api.delete('/api/products/:product_id', async (req,res)=>{
    const { product_id } = req.params;
    try {
        const deleted = await db('products').delete().where('product_id', product_id).returning('*');
        return res.status(200).json({msg: `Producto eliminado`, product: deleted});
    } catch (error) {
        return res.status(500).json({product: `Error eliminando el producto ${product_id}`});
    }
});
/////////////////////////////////////////////////////////

//////////////////// Clients API /////////////////////////
api.post('/api/clients', async (req,res)=>{

    const { first_name,last_name,email,phone,address,area,city,state,postal_code } = req.body;

    if(!first_name || !last_name || !email || !phone || !address || !area || !city || !state || !postal_code){
        return res.status(400).json({
            error: true,
            msg: 'Faltan datos'
        })
    }

    try {
        const newclient = await db('clients').insert({
            first_name: first_name,
            last_name: last_name,
            email: email,
            phone: phone,
            address: address,
            area: area,
            city: city,
            state: state,
            postal_code: postal_code,
        }).returning('*')
        return res.status(201).json({
            msg: 'Cliente creado',
            client: newclient
        })
        
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            msg: 'Error creando cliente'
        })
    }

});

api.get('/api/clients', async (req,res)=>{
    try {
        const clients = await db.select('*').from('clients');
        return res.status(200).json({
            msg: 'Todos los clientes',
            clients: clients
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({msg: `Error obteniendo todos los clientes`});
        
    }
});

api.get('/api/clients/:client_id', async (req,res)=>{
    const { client_id } = req.params;
    try {
        const clients = await db.select('*').from('clients').where('client_id', client_id).first();
        return res.status(200).json({
            msg: 'cliente encontrado',
            clients: clients
        });
    } catch (error) {
        return res.status(500).json({msg: `Error obteniendo el cliente: ${client_id}`});
    }
});

api.put('/api/clients/:client_id', async (req,res)=>{
    const { client_id } = req.params;
    const { first_name,last_name,email,phone,address,area,city,state,postal_code } = req.body;

    try {
        const updated = await db('clients').update({
            first_name: first_name,
            last_name: last_name,
            email: email,
            phone: phone,
            address: address,
            area: area,
            city: city,
            state: state,
            postal_code: postal_code
        }).where({
            client_id: client_id
        })
        .returning('*');
        return res.status(200).json({
            msg: 'cliente actualizado',
            clients: updated[0]
        });
    } catch (error) {
        return res.status(500).json({msg: `Error obteniendo el cliente ${client_id}`});
    }
});

api.delete('/api/clients/:client_id', async (req,res)=>{
    const { client_id } = req.params;
    try {
        const deleted = await db('clients').delete().where('client_id', client_id).returning('*');
        return res.status(200).json({msg: `cliente eliminado`, client: deleted});
    } catch (error) {
        return res.status(500).json({client: `Error eliminando el cliente ${client_id}`});
    }
});
////////////////////////////////////////////////////////


//////////////////// Sales API /////////////////////////
api.post('/api/sales', async (req,res)=>{

    const sale_array = req.body;
    let neworder_id;

    
    try {
        const neworder = await db('orders').insert({
            client_id: sale_array[0].client_id,
        }).returning('order_id')
        neworder_id = neworder[0].order_id;
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            msg: 'Error creando orden'
        })
    }

    for (let i = 0; i < sale_array.length; i++) {
        sale_array[i].order_id = neworder_id;
        delete sale_array[i].client_id;
    }

    console.log(sale_array);
    
    try {
        const newsale = await db('sales').insert(sale_array).returning('*')
        return res.status(201).json({
            msg: 'Venta agregada',
            sale: newsale
        })
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            msg: 'Error creando venta'
        })
    }


});


//////////////////////////////////////////////////////////


api.listen(8000, () => {
    console.log('Server running on port 8000');
});