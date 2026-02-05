
    %% 定义节点样式
    classDef inputNode fill:#fff3cd,stroke:#ffc107,stroke-width:2px;
    classDef calcNode fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef mathNode fill:#f9f,stroke:#333,stroke-width:1px,rx:10,ry:10;
    classDef finalNode fill:#d4edda,stroke:#28a745,stroke-width:3px;

    %% --- 1. 输入层 ---
    subgraph "输入变量 (Model Inputs)"
        I_in["原始输入图像 I_CC(x)"]:::inputNode
        B_in["空间背景光 B(x)<br>(来自 Final Refined Background Light B)"]:::inputNode
        t_in["直接传输率 t(x)<br>(来自 Final Transmission t)"]:::inputNode
    end

    %% --- 2. 传输率转换 ---
    subgraph "步骤 1: 传输率转换 (Transmission Conversion)"
        t_in -->|平方运算 (^2)| Math1["数学推导:<br>t'(x) = t(x)^2"]:::mathNode
        Math1 --> t_prime["入散射传输率<br>t'(x) = e^(-2cr)"]:::calcNode
        
        note1[">依据文档公式: t=e^(-cr), t'=e^(-2cr)"] -.-> Math1
    end

    %% --- 3. 计算散射项 ---
    subgraph "步骤 2: 估算入散射面纱 (Veil Estimation)"
        t_prime --> Math2["1 - t'(x)"]:::mathNode
        Math2 --"乘法 (x)"--> Mult1["B(x) * (1 - t'(x))"]:::mathNode
        B_in --> Mult1
        Mult1 --> Veil["入散射信号 (Haze/Veil)"]:::calcNode
    end

    %% --- 4. 逆向复原 ---
    subgraph "步骤 3: 图像逆向复原 (Image Restoration)"
        I_in --"减法 (-)"--> Sub1["去除面纱:<br>I_CC(x) - (B(x)*(1-t'(x)))"]:::mathNode
        Veil --> Sub1
        
        Sub1 --"除法 (/)"--> Div1["衰减补偿:<br>Divide by t(x)"]:::mathNode
        t_in -.->|"作为分母 t(x)"| Div1
        
        Div1 --> J_out["最终复原图像 J(x)<br>(Scene Radiance)"]:::finalNode
    end

    %% 引用标注
    noteEq["复原公式:<br>J(x) = [I_CC(x) - B(x)(1 - t'(x))] / t(x)"] -.-> Div1
