local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Function to create and configure a BillboardGui with custom text and delay
local function createBillboardGui(adornee, text, delay)
    -- Create a BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(2, 0, 2, 0)
    billboardGui.Adornee = adornee -- Attach to specified adornee
    billboardGui.AlwaysOnTop = true
    billboardGui.StudsOffset = Vector3.new(0, 2, 0) -- Adjust to position
    billboardGui.Enabled = false -- Start hidden

    -- Create a Frame for background
    local frame = Instance.new("Frame", billboardGui)
    frame.Size = UDim2.new(1, 0, 1, 0) -- Size same as TextLabel
    frame.BackgroundColor3 = Color3.new(1, 1, 1) -- White background
    frame.BackgroundTransparency = 1 -- Start fully transparent
    frame.BorderSizePixel = 1 -- With border

    -- Create a TextLabel
    local textLabel = Instance.new("TextLabel", billboardGui)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(0, 0, 0) -- Black text
    textLabel.TextScaled = true
    textLabel.Text = text

    -- Function to fade in the Frame and TextLabel
    local function fadeIn(frame, label, duration)
        frame.Visible = true -- Make the frame visible before starting to fade in
        for i = 0, 1, 0.05 do -- Incrementally change transparency
            frame.BackgroundTransparency = 1 - i -- Fade in the frame
            label.TextTransparency = 1 - i -- Fade in the text
            wait(duration / 20) -- Adjust for smoother animation (20 steps)
        end
    end

    -- Function to fade out the Frame and TextLabel
    local function fadeOut(frame, label, duration)
        for i = 0, 1, 0.05 do -- Incrementally change transparency
            frame.BackgroundTransparency = i -- Change the frame's transparency
            label.TextTransparency = i -- Change text transparency
            wait(duration / 20) -- Adjust for smoother animation (20 steps)
        end
        frame.Visible = false -- Hide the frame after fading out
    end

    -- Function to display text with fade-in and fade-out after delay
    local function displayText()
        wait(delay) -- Wait for the specified delay before showing
        billboardGui.Enabled = true -- Make the BillboardGui visible
        fadeIn(frame, textLabel, 1) -- Fade in over 1 second
        wait(3.8) -- Show the text for 3.8 seconds
        fadeOut(frame, textLabel, 1) -- Fade out over 1 second
    end

    billboardGui.Parent = adornee
    coroutine.wrap(displayText)() -- Start the displayText function in a coroutine

    return billboardGui
end

-- Attach BillboardGui to LeftArm with text "Domain Expansion" and no delay
local leftArm = character["Left Arm"].LeftShoulderAttachment
local leftArmBillboardGui = createBillboardGui(leftArm, "Domain Expansion", 0)

-- Attach BillboardGui to Head with text "Awakening" and 2-second delay
local head = character["Right Arm"].RightShoulderAttachment
local headBillboardGui = createBillboardGui(head, "Malevolent Shrine", 2)

-- Optionally, destroy the BillboardGuis after use
wait(5) -- Wait to observe the BillboardGuis on Head and Left Arm
leftArmBillboardGui:Destroy()
headBillboardGui:Destroy()
