local lib = {}
local ui = {}

function ui:new(class, data)
    local obj = Instance.new(class)
    for i,v in pairs(data) do
        if i ~= "Parent" then
            if typeof(v) == "Instance" then
                v.Parent = obj
            else
                obj[i] = v
            end
        end
    end
    obj.Parent = data.Parent
    return obj
end

function lib.start()
    local lib = ui:new("ScreenGui", {
        Parent = game:GetService("CoreGui");
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ui:new("Frame", {
            Active = true;
            Draggable = true;
            BackgroundColor3 = Color3.fromRGB(30, 30, 30);
            BorderSizePixel = 0;
            Position = UDim2.new(0.392743468, 0, 0.280548632, 0);
            Size = UDim2.new(0, 336, 0, 352);
            ui:new("Frame", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                BorderSizePixel = 0;
                Size = UDim2.new(0, 336, 0, 3);
                ui:new("UIGradient", {
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(55, 177, 218)); 
                        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(235, 93, 183));
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(204, 227, 53));
                    }
                })
            });
            ui:new("TextBox", {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30);
                BorderColor3 = Color3.fromRGB(100, 100, 100);
                Position = UDim2.new(0.202380955, 0, 0.622159064, 0);
                Size = UDim2.new(0, 200, 0, 32);
                Font = Enum.Font.Cartoon;
                Text = "Insert key here";
                TextColor3 = Color3.fromRGB(200, 200, 200);
                TextSize = 14;
            });
            ui:new("TextButton", {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30);
                BorderColor3 = Color3.fromRGB(100, 100, 100);
                Position = UDim2.new(0.202380955, 0, 0.752840877, 0);
                Size = UDim2.new(0, 200, 0, 50);
                Font = Enum.Font.SourceSans;
                Text = "Submit";
                TextColor3 = Color3.fromRGB(200, 200, 200);
                TextSize = 14;
            });
            ui:new("TextButton", {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30);
                BorderColor3 = Color3.fromRGB(100, 100, 100);
                Position = UDim2.new(0.202380955, 0, 0.292613626, 0);
                Size = UDim2.new(0, 200, 0, 50);
                Font = Enum.Font.SourceSans;
                Text = "Join Discord Server Now";
                TextColor3 = Color3.fromRGB(200, 200, 200);
                TextSize = 14;
            });
            ui:new("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30);
                BorderSizePixel = 0;
                Position = UDim2.new(0.0982142836, 0, 0.0482954532, 0);
                Size = UDim2.new(0, 277, 0, 38);
                Font = Enum.Font.SourceSans;
                Text = "Please supply a key";
                TextColor3 = Color3.fromRGB(255, 255, 255);
                TextSize = 20;
                TextWrapped = true;
            });
            ui:new("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30);
                BorderSizePixel = 0;
                Position = UDim2.new(0.0982142836, 0, 0.156250015, 0);
                Size = UDim2.new(0, 277, 0, 38);
                Font = Enum.Font.SourceSans;
                Text = "The key can be found in the discord server in channel #key";
                TextColor3 = Color3.fromRGB(255, 255, 255);
                TextSize = 16;
                TextWrapped = true;
            });
            ui:new("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30);
                BorderSizePixel = 0;
                Position = UDim2.new(0.098214291, 0, 0.477272749, 0);
                Size = UDim2.new(0, 277, 0, 38);
                Font = Enum.Font.SourceSans;
                Text = "Copy the key and insert it in the textbox below";
                TextColor3 = Color3.fromRGB(255, 255, 255);
                TextSize = 16;
                TextWrapped = true;
            });
        })
    })
end

lib.start()
return lib
