-- Active: 1748186718210@@127.0.0.1@5432@conservation_db

-- Rangers table creating
CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    region VARCHAR(50) NOT NULL,
    UNIQUE(ranger_id)
);

-- Species table creating
CREATE Table species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50),
    UNIQUE(species_id)
);

-- Sightings table creating
CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
    species_id INTEGER NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50) NOT NULL,
    notes VARCHAR(250),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    UNIQUE(sighting_id)
);

-- Inserting data into rangers table
INSERT INTO rangers(name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

-- Instering data into species table
INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-02-01', 'Endangered');

-- Inserting data into sighting table
INSERT INTO sightings(species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- Problem 1
INSERT INTO rangers(name, region) VALUES
('Derek Fox', 'Coastal Plains');


-- Problem 2
SELECT COUNT(DISTINCT scientific_name) as unique_species_count
FROM species;


-- Problem 3
SELECT * FROM sightings
WHERE location ILIKE '%Pass%';


-- Problem 4
SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings
FROM rangers
LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY  rangers.name
ORDER BY rangers.name ASC;


-- Problem 5
