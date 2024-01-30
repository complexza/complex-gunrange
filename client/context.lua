lib.registerContext({
    id = 'main_firearms_menu',
    title = 'Ammunation Firearms Test',
    options = {
        {
            title = 'Choose Difficulty',
            description = 'This will start the test, but you will have to choose the difficulty level',
            icon = 'fas fa-gun',
            onSelect = function()
                openDifficultyMenu()
            end,
        },
    }
}) 

lib.registerContext({
    id = 'difficulty_firearms_menu',
    title = 'Choose Difficulty Level',
    options = {
        {
            title = 'Easy',
            description = 'Easiest Mode - L if you do this.',
            icon = 'fas fa-gun',
            onSelect = function()
                startTest(1)
            end,
        },
        {
            title = 'Medium',
            description = 'Medium Mode.',
            icon = 'fas fa-gun',
            onSelect = function()
                startTest(2)
            end,
        },
        {
            title = 'Hard',
            description = 'Hardest Mode - W if you do this.',
            icon = 'fas fa-gun',
            onSelect = function()
                startTest(3)
            end,
        },
    }
}) 