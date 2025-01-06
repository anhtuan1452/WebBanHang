CREATE DATABASE WEB
USE WEB
-- Bảng Users: Lưu thông tin người dùng
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
    password NVARCHAR(255) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    phone_number NVARCHAR(15),
    address NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng Categories: Lưu thông tin danh mục sản phẩm
CREATE TABLE Categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
);

-- Bảng Products: Lưu thông tin sản phẩm
CREATE TABLE Products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nameProduct NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    price INT NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    brand NVARCHAR(100),
    image_url NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES Categories(id)
);

-- Bảng Orders: Lưu thông tin các đơn hàng
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT N'Đang Xử Lý',
    total_amount INT,
    shipping_address NVARCHAR(MAX),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);


-- Bảng Order_Items: Lưu thông tin chi tiết các sản phẩm trong đơn hàng
CREATE TABLE Order_Items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- Bảng Reviews: Lưu thông tin đánh giá sản phẩm của người dùng
CREATE TABLE Reviews (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);
