CREATE DATABASE CakeShop;
USE CakeShop;
CREATE TABLE cakes (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- شناسه یکتا برای هر کیک
    name VARCHAR(255) NOT NULL,              -- نام کیک
    price INT NOT NULL,                      -- قیمت کیک
    discounted_price INT,                    -- قیمت تخفیف‌خورده (اختیاری)
    rating FLOAT DEFAULT 0,                  -- امتیاز کیک
    image VARCHAR(255),                      -- آدرس عکس کیک
    description TEXT,                        -- توضیحات کیک
    stock INT NOT NULL,                      -- تعداد موجودی
    is_discounted BOOLEAN DEFAULT FALSE,     -- آیا تخفیف دارد؟
    categories VARCHAR(255) NOT NULL,        -- دسته‌بندی‌ها
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- زمان ایجاد
);
INSERT INTO cakes (name, price, discounted_price, rating, image, description, stock, is_discounted, categories)
VALUES
('my peace cake', 800000, NULL, 0, 'assets/aramejan.png', 'کیک عاشقانه ۱ کیلویی فوندانتی با استند آرام جان', 3, FALSE, 'anniversary,fondant'),

('carrot cake', 600000, 550000, 0, 'assets/carrot.png', 'کیک ۱ کیلویی هویج با دیزاین ساده و مینیمال همراه با فشفشه برای سالگرد ازدواج', 5, TRUE, 'anniversary,cream,fondant'),

('sweet 16 cake', 650000, NULL, 0, 'assets/crepe.png', 'کیک نیم کیلویی با تزیین گل خامه‌ای برای ۱۶ امین سالگرد ازدواج', 2, FALSE, 'anniversary,cream'),

('happy couple cake', 750000, NULL, 0, 'assets/dumb&dumber.png', 'کیک نیم کیلویی بامزه برای زوج‌های شوخ', 2, FALSE, 'anniversary'),

('rose cake', 1400000, NULL, 0, 'assets/rose.png', 'کیک ۲ کیلویی خامه‌ای با دیزاین کلاسیک طلایی و گل رز طبیعی', 5, FALSE, 'anniversary,birthday,fondant'),

('shiny hearts cake', 1000000, NULL, 0, 'assets/shinyhearts.png', 'کیک ۲ کیلویی خامه‌ای براق با دیزاین قلب‌های رز گلد', 6, FALSE, 'anniversary,cream'),

('strawberry naked cake', 450000, 400000, 0, 'assets/plain.png', 'کیک ساده وانیلی ۱ کیلویی با فیلینگ و دیزاین مارمالاد توت فرنگی تازه', 3, TRUE, 'anniversary,birthday'),

('25 hearts cake', 750000, NULL, 0, 'assets/heart.png', 'کیک جذاب نیم کیلویی با دیزاین قلب‌های کوچک برای ۲۵ امین سالگرد ازدواج', 1, FALSE, 'anniversary,cream'),

('piano love cake', 1050000, NULL, 0, 'assets/piano.png', 'کیک ۱ کیلویی فوندانتی با طرح پیانو برای ۱۸ امین سالگرد ازدواج', 2, FALSE, 'anniversary,fondant'),

('sky love cake', 950000, NULL, 0, 'assets/sky.png', 'کیک ۱ کیلویی خامه‌ای با طرح آسمان برای ۱۶ امین سالگرد ازدواج', 4, FALSE, 'anniversary'),

('emerald mini cake', 800000, NULL, 0, 'assets/zomorod.png', 'کیک نیم کیلویی خامه‌ای با رنگ سبز زمردی و دیزاین ورق طلا', 10, FALSE, 'birthday'),

('tiffany cake', 900000, NULL, 0, 'assets/tiffany2.png', 'کیک ۱.۵ کیلویی با رنگ تیفانی و بنفش و دیزاین گل ارکیده طبیعی', 5, FALSE, 'birthday'),

('sunflower cake', 750000, NULL, 0, 'assets/sunflower.png', 'کیک یک کیلویی با دیزاین گل‌های آفتاب‌گردان فوندانتی', 8, FALSE, 'birthday'),

('gray marble cake', 850000, NULL, 0, 'assets/marble2.png', 'کیک ۱ کیلویی فوندانتی با طرح مرمر طوسی و رگه‌های طلایی', 11, FALSE, 'birthday,fondant'),

('orchid marble cake', 1200000, NULL, 0, 'assets/marble.png', 'کیک ۱.۵ کیلویی فوندانتی با طرح مرمر و گل‌های طبیعی ارکیده', 4, FALSE, 'birthday,fondant'),

('purple geode cake', 1000000, NULL, 0, 'assets/geode.png', 'کیک ۱ کیلویی خامه‌ای با طرح ژئود بنفش', 8, FALSE, 'birthday'),

('black marble cake', 500000, 450000, 0, 'assets/black.png', 'کیک ۳ کیلویی فوندانتی با طرح مرمر سیاه', 5, TRUE, 'birthday,fondant'),

('breaking bad cake', 850000, NULL, 0, 'assets/breakingbad.png', 'کیک خامه‌ای ۲ کیلویی با تم سریال بریکینگ بد', 7, FALSE, 'birthday,kids'),

('flamingo cake', 750000, NULL, 0, 'assets/flamingo.jpg', 'کیک یک و نیم کیلویی بامزه خامه‌ای با تزیین تابستانی', 5, FALSE, 'cream,kids'),

('monster bento cake', 300000, 250000, 0, 'assets/monster.png', 'کیک بنتو طرح دانشگاه هیولاها', 10, TRUE, 'bento'),

('monster & boo bento cake', 300000, 260000, 0, 'assets/monster2.png', 'کیک بنتو طرح هیولا و بوو', 10, TRUE, 'bento'),

('sea bento cake', 300000, 270000, 0, 'assets/sea.png', 'کیک بنتو طرح دریا', 10, TRUE, 'bento'),

('white bento cake', 300000, 280000, 0, 'assets/sefid.png', 'کیک بنتو قلبی سفید', 10, TRUE, 'bento'),

('sun flower cake', 750000, NULL, 0, 'assets/sunflower.png', 'کیک یک کیلویی با دیزاین گل‌های آفتاب‌گردان فوندانتی.', 8, FALSE, 'birthday'),

('violet cake', 800000, NULL, 0, 'assets/purple2.png', 'کیک ۲ کیلویی خامه‌ای با دیزاین بنفش و گل‌های طبیعی.', 6, FALSE, 'birthday'),

('ocean cake', 750000, NULL, 0, 'assets/ocean.png', 'کیک جذاب ۱.۵ کیلویی با طرح اقیانوس آبی.', 9, FALSE, 'birthday'),

('gold & gray cake', 950000, NULL, 0, 'assets/gray.png', 'کیک ۲ کیلویی با طراحی مدرن طوسی و طلایی.', 6, FALSE, 'birthday'),

('flowers cake', 1200000, NULL, 0, 'assets/flowers.png', 'کیک ۲ کیلویی خامه‌ای با گل‌های طبیعی رنگارنگ.', 10, FALSE, 'birthday'),

('emerald cake', 1100000, NULL, 0, 'assets/zomorod2.png', 'کیک ۱.۵ کیلویی خامه‌ای جذاب با رنگ سبز زمردی و دیزاین ورق طلا.', 8, FALSE, 'birthday'),

('the frog cake', 1050000, NULL, 0, 'assets/thefrog.png', 'کیک ۲ کیلویی خامه‌ای بامزه با غورباقه کوچولو.', 3, FALSE, 'birthday,cream'),

('updated cake', 700000, 650000, 0, 'assets/updated.png', 'کیک نیم کیلویی خامه‌ای ساده و بامزه.', 3, TRUE, 'birthday,cream'),

('dunot cake', 800000, NULL, 0, 'assets/doughnut.png', 'کیک خامه‌ای یک و نیم کیلویی با تزیین دوناتی.', 4, FALSE, 'cream'),

('pink lemonade cake', 900000, NULL, 0, 'assets/pinklemonade.png', 'کیک ۲ کیلویی خامه‌ای با دیزاین شاد و تابستانی.', 7, FALSE, 'cream'),

('silver cake', 750000, 700000, 0, 'assets/silver.png', 'کیک ساده ۱ کیلویی با دیزاین طوسی و نقره‌ای.', 3, TRUE, 'cream'),

('ocean ruffle cake', 750000, NULL, 0, 'assets/raffel.png', 'کیک نیم کیلویی با دیزاین رافل اقیانوسی فوندانتی.', 2, FALSE, 'birthday,fondant'),

('avengners cake', 1000000, 900000, 0, 'assets/avengers.png', 'کیک کودکانه اونجرز عدد ۷ انگلیسی.', 3, TRUE, 'kids'),

('barbie cake', 1300000, NULL, 0, 'assets/barbie.png', 'کیک کودکانه با دیزاین باربی پرینسس.', 4, FALSE, 'kids'),

('paw patrols cake', 1400000, NULL, 0, 'assets/pawpatrols.png', 'کیک کودکانه با دیزاین سگ‌های نگهبان.', 3, FALSE, 'kids'),

('pj masks cake', 1000000, NULL, 0, 'assets/pjmasks.png', 'کیک کودکانه با طرح پی جی ماسک‌ها.', 1, FALSE, 'kids'),

('mini pj masks cake', 900000, NULL, 0, 'assets/pjmasks2.png', 'کیک کودکانه کوچک با طرح پی جی ماسک‌ها.', 3, FALSE, 'kids'),

('sponge bob cake', 1000000, NULL, 0, 'assets/spongebob.png', 'کیک کودکانه با طرح باب اسفنجی.', 4, FALSE, 'kids'),

('teeth cake', 800000, NULL, 0, 'assets/teeth.png', 'کیک کودکانه کوچک دندونی.', 2, FALSE, 'kids'),

('the owl cake', 1000000, NULL, 0, 'assets/the owl.png', 'کیک کودکانه با طرح جغد رنگارنگ.', 1, FALSE, 'kids');
SELECT * FROM cakes;
