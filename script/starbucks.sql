CREATE TABLE categories (
    category_id TINYINT NOT NULL,
    category_name VARCHAR(20) NOT NULL
);

CREATE TABLE products (
    menu_name VARCHAR(50) NOT NULL,
    category_id TINYINT NOT NULL COMMENT 'fk',
    menu_eng_name VARCHAR(50) NOT NULL,
    menu_description VARCHAR(200) NOT NULL,
    menu_image LONGBLOB NOT NULL,
    is_new TINYINT(1) NOT NULL DEFAULT 0,
    is_limited TINYINT(1) NULL DEFAULT 0,
    category_id2 TINYINT NOT NULL
);

CREATE TABLE nutritions (
    menu_name VARCHAR(50) NOT NULL,
    calory SMALLINT NOT NULL,
    carbo DECIMAL NULL,
    protein DECIMAL NULL,
    sodium DECIMAL NULL,
    saturated_fat DECIMAL NULL,
    caffeine DECIMAL NULL,
    id VARCHAR(10) NOT NULL
);

CREATE TABLE allergic_factor (
    menu_name2 VARCHAR(50) NOT NULL,
    soy_bean TINYINT(1) NOT NULL DEFAULT 0,
    milk TINYINT(1) NOT NULL DEFAULT 0,
    eggs TINYINT(1) NOT NULL DEFAULT 0,
    wheat TINYINT(1) NOT NULL DEFAULT 0,
    nuts TINYINT(1) NOT NULL DEFAULT 0,
    seafood TINYINT(1) NOT NULL DEFAULT 0,
    peach TINYINT(1) NOT NULL DEFAULT 0
);
alter table allergic_factor rename column menu_name2 to menu_name ;

CREATE TABLE menu_size (
    id VARCHAR(10) NOT NULL,
    size VARCHAR(30) NOT NULL,
    capacity SMALLINT NOT NULL
);
commit;

