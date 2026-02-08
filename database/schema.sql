-- =========================
-- USERS
-- =========================
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    gender TEXT CHECK (gender IN ('M','F')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- USER PROFILE
-- =========================
CREATE TABLE user_profile (
    user_id UUID PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    age INT,
    height_cm INT,
    weight_kg INT,
    tshirt_size TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- USER PREFERENCES
-- =========================
CREATE TABLE user_preferences (
    preference_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    style TEXT,
    color_likes JSONB,
    color_dislikes JSONB,
    fit_preference TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CLOTHING ITEMS
-- =========================
CREATE TABLE clothing_items (
    item_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    category TEXT NOT NULL,
    sub_category TEXT,
    brand TEXT,
    season TEXT,
    occasion TEXT,
    purchase_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CLOTHING IMAGES
-- =========================
CREATE TABLE clothing_images (
    image_id UUID PRIMARY KEY,
    item_id UUID REFERENCES clothing_items(item_id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    vision_tags JSONB,
    dominant_colors JSONB,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- OUTFIT LOGS
-- =========================
CREATE TABLE outfit_logs (
    log_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    outfit_item_ids JSONB NOT NULL,
    worn_date DATE NOT NULL,
    occasion TEXT,
    weather TEXT,
    feedback TEXT CHECK (feedback IN ('liked', 'disliked', 'neutral')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- RECOMMENDATION LOGS
-- =========================
CREATE TABLE recommendation_logs (
    rec_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    type TEXT CHECK (type IN ('outfit', 'purchase')),
    input_context JSONB,
    output JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
