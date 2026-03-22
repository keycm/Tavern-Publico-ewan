<?php session_start(); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tavern Publico - Menu</title>
    <link rel="stylesheet" href="CSS/main.css">
    <link rel="stylesheet" href="CSS/dark-theme.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;0,800;1,600&family=Mada:wght@400;600;700&display=swap" rel="stylesheet">
    
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">

    <style>
        /* --- ORIGINAL MENU SECTION STYLES --- */
        .menu-section { padding: 40px 0; background-color: #f8f8f8; }
        .section-heading-v2 { margin-bottom: 40px; }
        
        .section-heading-v2 { text-align: center; }
        .section-heading-v2 .sub-title { font-size: 1.2em; color: #555; font-family: 'Mada', sans-serif; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 5px; }
        .title-with-lines { display: flex; align-items: center; justify-content: center; gap: 15px; }
        .title-with-lines .line { height: 2px; width: 50px; background-color: #FFD700; }
        .section-heading-v2 .main-title { font-size: 2.5em; color: #222; margin: 0; font-family: 'Mada', sans-serif; font-weight: 700; }
        
        body.dark-theme .menu-section { background-color: #121212; }
        body.dark-theme .section-heading-v2 .sub-title { color: #aaa; }
        body.dark-theme .section-heading-v2 .main-title { color: #f5f5f5; }

        /* --- Custom Logo Font Style --- */


        /* --- Sticky Menu Header (Filters & Search) --- */
        .menu-header {
            position: -webkit-sticky; 
            position: sticky;
            top: 94px; 
            z-index: 990; 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08); 
            width: 100%; 
            margin-bottom: 30px;
            border-radius: 10px;
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        body.dark-theme .menu-header {
             background: rgba(30, 30, 30, 0.95);
             box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        /* --- Category Buttons --- */
        .category-buttons-container { position: relative; width: 100%; flex-grow: 1; }
        .category-buttons { display: flex; flex-wrap: wrap; gap: 8px; }

        .category-btn { 
            background-color: #f0f0f0; 
            color: #555; 
            border: none; 
            padding: 8px 18px; 
            border-radius: 25px; 
            cursor: pointer; 
            font-size: 0.9em; 
            font-weight: 500; 
            transition: all 0.3s ease; 
            display: flex; 
            align-items: center; 
            gap: 8px; 
        }
        body.dark-theme .category-btn { background-color: #2a2a2a; color: #ccc; }

        .category-btn:hover { background-color: #e0e0e0; }
        body.dark-theme .category-btn:hover { background-color: #444; }
        
        .category-btn.active { 
            background-color: #FFD700; 
            color: #333; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.1); 
        }
        .category-btn.active i { color: #333; }

        /* --- Search (Sort removed) --- */
        .search-sort { display: flex; align-items: center; gap: 20px; flex-wrap: wrap; }
        .search-bar { position: relative; }
        .search-bar input { 
            padding: 10px 15px 10px 40px; 
            border: 1px solid #ddd; 
            border-radius: 25px; 
            font-size: 0.95em; 
            width: 250px; 
            transition: border-color 0.3s ease; 
        }
        body.dark-theme .search-bar input { background: #222; border-color: #444; color: #fff; }
        .search-bar input:focus { border-color: #FFD700; outline: none; }
        .search-bar i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #999; }

        /* --- FLIP CARD FOOD ITEMS UI --- */
        .menu-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); 
            gap: 30px; 
            justify-content: center; 
        }
        
        .flip-card {
            background-color: transparent;
            height: 350px;
            perspective: 1000px; 
            cursor: pointer;
        }

        .flip-card-inner {
            position: relative;
            width: 100%;
            height: 100%;
            text-align: center;
            transition: transform 0.6s cubic-bezier(0.4, 0.2, 0.2, 1);
            transform-style: preserve-3d;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        /* Javascript handles the flipping now, not hover */
        .flip-card.flipped .flip-card-inner {
            transform: rotateY(180deg);
        }

        body.dark-theme .flip-card-inner {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .flip-card-front, .flip-card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
            border-radius: 15px;
            overflow: hidden;
        }

        /* Front Side: Full Picture */
        .flip-card-front {
            background-color: #fff;
            color: black;
        }
        
        .flip-card-front img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        /* Slight zoom on hover, but no flip */
        .flip-card:hover .flip-card-front img {
            transform: scale(1.05);
        }

        .front-title-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.4) 60%, transparent 100%);
            padding: 30px 20px 15px;
            color: #fff;
            text-align: left;
        }

        .front-title-overlay h3 {
            margin: 0;
            font-family: 'Playfair Display', serif;
            font-size: 1.5em;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.5);
        }

        /* Back Side: Description Only */
        .flip-card-back {
            background-color: #1a1a1a; 
            color: white;
            transform: rotateY(180deg);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 30px 20px;
            text-align: center;
        }

        body.dark-theme .flip-card-back {
            background-color: #222;
            border: 1px solid #333;
        }

        .flip-card-back h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.6em;
            color: #FFD700;
            margin-top: 0;
            margin-bottom: 15px;
            line-height: 1.2;
        }

        .flip-card-back .desc {
            font-family: 'Mada', sans-serif;
            font-size: 1em;
            color: #ddd;
            line-height: 1.6;
        }

        /* Animation Classes for Grid */
        .menu-item-card {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.5s ease-out, transform 0.5s ease-out;
            visibility: hidden;
        }
        .menu-item-card.is-visible {
            opacity: 1;
            transform: translateY(0);
            visibility: visible;
        }

        /* Scroll to Top Button */
        #scrollTopBtn {
            display: none; 
            position: fixed;
            bottom: 25px;
            left: 25px; 
            z-index: 1001;
            border: none;
            outline: none;
            background-color: #FFD700; 
            color: #1a1a1a;
            cursor: pointer;
            padding: 0;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 22px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transition: background-color 0.3s, opacity 0.3s, transform 0.2s;
            justify-content: center; 
            align-items: center; 
        }

        #scrollTopBtn:hover { background-color: #e6c200; transform: scale(1.05); }
        body.dark-theme #scrollTopBtn { box-shadow: 0 4px 8px rgba(0,0,0,0.3); }

        /* --- Mobile Responsiveness --- */
        @media (max-width: 1024px) {
            .menu-header { flex-direction: column; align-items: flex-start; }
            .search-sort { width: 100%; justify-content: space-between; }
            .search-bar { flex-grow: 1; }
            .search-bar input { width: 100%; }
        }
        
        @media (max-width: 768px) {
            .menu-section { padding-top: 25px; }
            .section-heading-v2 { margin-bottom: 15px; }
            .menu-header { padding: 15px; margin-bottom: 30px; flex-direction: column; align-items: stretch; top: 94px; } 
            
            .category-buttons {
                display: flex;
                overflow-x: auto;
                flex-wrap: nowrap;
                padding-bottom: 15px;
                -ms-overflow-style: none;
                scrollbar-width: none;
            }
            .category-buttons::-webkit-scrollbar { display: none; }
            .category-btn { flex-shrink: 0; }
            
            .search-sort { flex-direction: row; align-items: center; gap: 15px; width: 100%; justify-content: space-between; }
            .search-bar { flex-grow: 1; }
            .search-bar input { width: 100%; }
            
            .menu-grid { grid-template-columns: repeat(2, 1fr); gap: 20px; }

            .flip-card { height: 280px; }
            .front-title-overlay h3 { font-size: 1.1em; }
            .flip-card-back h3 { font-size: 1.2em; margin-bottom: 10px; }
            .flip-card-back .desc { font-size: 0.85em; }

            .swipe-indicator { display: flex; align-items: center; position: absolute; top: 50%; right: 0; transform: translateY(-50%); background-color: rgba(0,0,0,0.7); color: #fff; padding: 8px 15px; border-radius: 20px; font-size: 0.85em; z-index: 10; pointer-events: none; opacity: 1; transition: opacity 0.5s ease; }
            .swipe-indicator.hide { opacity: 0; }
        }
    </style>
</head>
<body>

    <?php
    include 'partials/header.php';
    include 'config.php';
    ?>

    <main>
        <section class="menu-section common-padding">
            <div class="container">
                

                <div class="section-heading-v2">
                    <div class="sub-title">Explore Our</div>
                    <div class="title-with-lines">
                        <div class="line"></div>
                        <h2 class="main-title">Delicious Menu</h2>
                        <div class="line"></div>
                    </div>
                </div>

                <div class="menu-header"> 
                    <div class="category-buttons-container">
                        <div class="category-buttons">
                            <button class="category-btn active" data-category="All"><i class="fas fa-list"></i><span class="btn-text">All Items</span></button>
                            <button class="category-btn" data-category="Specialty"><i class="fas fa-utensils"></i><span class="btn-text">Specialty</span></button>
                            <button class="category-btn" data-category="Appetizer"><i class="fas fa-concierge-bell"></i><span class="btn-text">Appetizer</span></button>
                            <button class="category-btn" data-category="Breakfast"><i class="fas fa-egg"></i><span class="btn-text">All Day Breakfast</span></button>
                            <button class="category-btn" data-category="Lunch"><i class="fas fa-drumstick-bite"></i><span class="btn-text">Ala Carte/For Sharing</span></button>
                            <button class="category-btn" data-category="Sizzlers"><i class="fas fa-fire-alt"></i><span class="btn-text">Sizzling Plates</span></button>
                            <button class="category-btn" data-category="Coffee"><i class="fas fa-coffee"></i><span class="btn-text">Cafe Drinks</span></button>
                            <button class="category-btn" data-category="Non-Coffee"><i class="fas fa-mug-hot"></i><span class="btn-text">Non-Coffee</span></button>
                            <button class="category-btn" data-category="Cool Creations"><i class="fas fa-blender"></i><span class="btn-text">Frappe</span></button>
                            <button class="category-btn" data-category="Cakes"><i class="fas fa-birthday-cake"></i><span class="btn-text">Cakes</span></button>
                        </div>
                        <div class="swipe-indicator">Swipe <i class="fas fa-hand-pointer"></i></div>
                    </div>
                    <div class="search-sort">
                        <div class="search-bar">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Search menu...">
                        </div>
                        </div>
                </div>
                
                <div class="menu-grid" id="menuGrid">
                    <?php
                     if (!isset($conn) || !$conn || $conn->connect_error) { 
                         include 'config.php'; 
                     }

                    $sql = "SELECT * FROM menu WHERE deleted_at IS NULL ORDER BY category, name";
                    $result = $conn->query($sql);

                    if ($result && $result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            
                            // Using toggleFlip logic directly on the card
                            echo '<div class="menu-item-card flip-card" onclick="toggleFlip(this)"
                                    data-name="' . htmlspecialchars($row['name'], ENT_QUOTES) . '"
                                    data-category="' . htmlspecialchars($row['category']) . '">';
                                    
                            echo '  <div class="flip-card-inner">';
                            
                            // Front of Card (Full Image + Overlay Title)
                            echo '      <div class="flip-card-front">';
                            echo '          <img src="' . htmlspecialchars($row['image']) . '" alt="' . htmlspecialchars($row['name']) . '">';
                            echo '          <div class="front-title-overlay">';
                            echo '              <h3>' . htmlspecialchars($row['name']) . '</h3>';
                            echo '          </div>';
                            echo '      </div>';
                            
                            // Back of Card (Title and Description Only)
                            echo '      <div class="flip-card-back">';
                            echo '          <h3>' . htmlspecialchars($row['name']) . '</h3>';
                            
                            $desc = !empty($row['description']) ? htmlspecialchars($row['description']) : 'A delicious offering from Tavern Publico.';
                            echo '          <p class="desc">' . $desc . '</p>';
                            echo '      </div>';
                            
                            echo '  </div>'; 
                            echo '</div>'; 
                        }
                    } else {
                        echo "<p>No menu items found.</p>";
                    }
                    ?>
                </div>
            </div>
        </section>
    </main>

    <button id="scrollTopBtn" title="Go to top"><i class="fas fa-arrow-up"></i></button>

    <?php
    include 'partials/footer.php';
    include 'partials/Signin-Signup.php';
     if (isset($conn) && $conn) { $conn->close(); }
    ?>

    <script src="JS/theme-switcher.js"></script>
    <script>
        // --- Flip Card Click Logic ---
        function toggleFlip(clickedCard) {
            const isAlreadyFlipped = clickedCard.classList.contains('flipped');

            // Find any currently flipped card and unflip it
            const currentlyFlippedCard = document.querySelector('.flip-card.flipped');
            if (currentlyFlippedCard) {
                currentlyFlippedCard.classList.remove('flipped');
            }

            // If the card we clicked wasn't already flipped, flip it
            if (!isAlreadyFlipped) {
                clickedCard.classList.add('flipped');
            }
        }

        document.addEventListener('DOMContentLoaded', () => {

            const categoryButtonsContainer = document.querySelector('.category-buttons');
            const swipeIndicator = document.querySelector('.swipe-indicator');

            if (categoryButtonsContainer && swipeIndicator) {
                if (categoryButtonsContainer.scrollWidth > categoryButtonsContainer.clientWidth) {
                    swipeIndicator.style.display = 'flex';
                } else {
                    swipeIndicator.style.display = 'none';
                }
                categoryButtonsContainer.addEventListener('scroll', () => {
                    swipeIndicator.classList.add('hide');
                }, { once: true });
            }

            const categoryButtons = document.querySelectorAll('.category-btn');
            const searchInput = document.getElementById('searchInput');
            const menuGrid = document.querySelector('.menu-grid');
            
            const allMenuItems = Array.from(document.querySelectorAll('.menu-item-card'));

            // Simplified Filtering (Sort Logic Removed)
            const filterMenu = () => {
                const activeCategoryBtn = document.querySelector('.category-btn.active');
                if (!activeCategoryBtn || !searchInput || !menuGrid) return;
                
                const activeCategory = activeCategoryBtn.dataset.category;
                const searchTerm = searchInput.value.toLowerCase();
                
                allMenuItems.forEach(item => {
                    const isVisibleByCategory = activeCategory === 'All' || item.dataset.category === activeCategory;
                    const itemName = item.dataset.name.toLowerCase();
                    const isVisibleBySearch = itemName.includes(searchTerm);
                    item.style.display = (isVisibleByCategory && isVisibleBySearch) ? 'flex' : 'none';
                });

                // Re-trigger grid animation
                const visibleItems = allMenuItems.filter(item => item.style.display !== 'none');
                menuGrid.innerHTML = '';
                visibleItems.forEach((item, index) => {
                    item.classList.remove('is-visible');
                    menuGrid.appendChild(item);
                    setTimeout(() => item.classList.add('is-visible'), 50);
                });
            };

            categoryButtons.forEach(button => {
                button.addEventListener('click', () => {
                    categoryButtons.forEach(btn => btn.classList.remove('active'));
                    button.classList.add('active');
                    filterMenu();
                });
            });

            if(searchInput) searchInput.addEventListener('input', filterMenu);

            const menuItems = document.querySelectorAll('.menu-item-card');

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('is-visible');
                        observer.unobserve(entry.target);
                    }
                });
            }, {
                threshold: 0.1
            });

            menuItems.forEach((item, index) => {
                item.style.transitionDelay = `${index * 50}ms`;
                observer.observe(item);
            });

            filterMenu(); 

            // --- Scroll to Top Button JavaScript ---
            const scrollTopBtn = document.getElementById('scrollTopBtn');

            if (scrollTopBtn) {
                window.onscroll = function() {
                    scrollFunction();
                };

                function scrollFunction() {
                    if (window.scrollY > 200 || document.documentElement.scrollTop > 200) {
                        scrollTopBtn.style.display = "flex"; 
                    } else {
                        scrollTopBtn.style.display = "none";
                    }
                }

                scrollTopBtn.addEventListener('click', () => {
                    window.scrollTo({
                        top: 0,
                        behavior: 'smooth'
                    });
                });
            }
        });
    </script>
</body>
</html>