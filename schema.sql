CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    delivery_date DATE,
    agent_id INT,
    status VARCHAR(20),
    city VARCHAR(50),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);
