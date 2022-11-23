return {
    Day = {
        Lighting = {
            Ambient = Color3.new(0.35294117647058826, 0.35294117647058826, 0.35294117647058826);
            OutdoorAmbient = Color3.new(0.611764705882353, 0.6588235294117647, 0.7450980392156863);
            Brightness = 3.5;
            ColorShift_Top = Color3.new(0, 0, 0);
        };
        Atmosphere = {
            Density = 0.22;
            Color = Color3.new(0.9019607843137255, 0.4470588235294118, 0.3411764705882353); 
            Glare = 0.4; 
            Haze = 2.03;
        };
        Clouds = {
            Cover = 0.65;
            Density = 0.5;
            Color = Color3.new(0.8862745098039215, 0.49411764705882355, 0.3568627450980392);
        };
        ColorCorrection = {
            TintColor = Color3.new(1, 1, 1);
        };
    };
    Night = {
        Lighting = {
            Ambient = Color3.new(0.35294117647058826, 0.35294117647058826, 0.35294117647058826);
            OutdoorAmbient = Color3.new(0.37254901960784315, 0.4, 0.6274509803921569);
            Brightness = 3;
            ColorShift_Top = Color3.new(0.21568627450980393, 0.5686274509803921, 1);
        };
        Atmosphere = {
            Density = 0.35;
            Color = Color3.new(0.4, 0.4549019607843137, 0.5490196078431373);
            Glare = 0; 
            Haze = 2;
        };
        Clouds = {
            Cover = 0.554; 
            Density = 1;
            Color = Color3.new(0.32941176470588235, 0.43529411764705883, 0.6235294117647059);
        };
        ColorCorrection = {
            TintColor = Color3.new(1, 1, 1);
        }
    };
    Storm = {
        Lighting = {
            Ambient = Color3.new(0.35294117647058826, 0.35294117647058826, 0.35294117647058826);
            OutdoorAmbient = Color3.new(0.37254901960784315, 0.4, 0.6274509803921569);
            Brightness = 2;
            ColorShift_Top = Color3.new(0.6901960784313725, 0.796078431372549, 1);
        };
        Atmosphere = {
            Density = 0.4;
            Color = Color3.new(0.615686274509804, 0.5803921568627451, 0.6039215686274509);
            Glare = 0;
            Haze = 2.14;
        };
        Clouds = {
            Cover = 0.73; 
            Density = 1;
            Color = Color3.new(0.45098039215686275, 0.5137254901960784, 0.6862745098039216);
        };
        ColorCorrection = {
            TintColor = Color3.new(0.8352941176470589, 0.9647058823529412, 1);
        }
    };
}
