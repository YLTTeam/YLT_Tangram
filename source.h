Config config {
    "version":"2.0",
    "response":"json",
    "pods":"YES",
    "filename":"Tangram"
}

enum LayoutGravity {
    Left = 1,
    Right = 2,
    Top = 4,
    Bottom = 8,
    V_center = 16,
    H_center = 32
}

enum DimDirection {
    X = 1,
    Y = 2,
    NONE = 4
}

enum CornerLocation {
    TopLeft = 1,
    TopRight = 2,
    BottomLeft = 4,
    BottomRight = 8,
    ALL = 16,
}

enum TextStyle {
    Normal = 1,
    Bold = 2,
    Italic = 4,
    Strike = 8,
    UnderLine = 16
}

enum ScaleType {
    Fit_start = 1,
    Fit_xy = 2,
    Matrix = 4,
    Center = 8,
    Center_crop = 16,
    Center_inside = 32,
    Fit_center = 64,
    Fit_end = 128,
}

enum Orientation {
    H = 1,
    V = 2
}

message TangramView {
    optional int tangramId(id) = 0;//组件id
    optional string layoutWidth = nil;//组件的布局宽度，与Android里的概念类似，写绝对值的时候表示绝对宽高，match_parent 表示尽可能撑满父容器提供的宽高，wrap_content 表示根据自身内容的宽高来布局
    optional string layoutHeight = nil;//组件的布局宽度，与Android里的概念类似，写绝对值的时候表示绝对宽高，match_parent 表示尽可能撑满父容器提供的宽高，wrap_content 表示根据自身内容的宽高来布局
    optional LayoutGravity layoutGravity = 48;//描述组件在容器中的对齐方式，left(1)：靠左，right(2)：靠右，top(4)：靠上，bottom(8)：靠底，v_center(16)：垂直方向居中，h_center(32)：水平方向居中，可用或组合描述  比如：靠左+靠上  1+4 = 5
    optional float autoDimX = 0;//组件宽高比计算的横向值
    optional float autoDimY = 0;//组件宽高比计算的竖向值
    optional DimDirection autoDimDirection = 0;//X、Y、NONE  组件在布局中的基准方向，用于计算组件的宽高比，与 autoDimX、autoDimY 配合使用，设置了这三个属性时，在计算组件尺寸时具有更高的优先级。当 autoDimDirection=X 时，组件的宽度由 layoutWidth 和父容器决策决定，但高度 = width * (autoDimY / autoDimX)，当 autoDimDirection=Y 时，组件的高度由 layoutHeight 和父容器决策决定，但宽度 = height * (autoDimX / autoDimY)
    optional float minWidth = 0;//最小宽度
    optional float minHeight = 0;//最小高度
    optional float padding = 0;//同时设置 4 个内边距
    optional float paddingLeft = 0;//左内边距，优先级高于 padding
    optional float paddingRight = 0;//右内边距，优先级高于 padding
    optional float paddingTop = 0;//上内边距，优先级高于 padding
    optional float paddingBottom = 0;//下内边距，优先级高于 padding
    optional float layoutMargin = 0;//同时设置 4 个外边距
    optional float layoutMarginLeft = 0;//左外边距，优先级高于 layoutMargin
    optional float layoutMarginRight = 0;//右外边距，优先级高于 layoutMargin
    optional float layoutMarginTop = 0;//上外边距，优先级高于 layoutMargin
    optional float layoutMarginBottom = 0;//下外边距，优先级高于 layoutMargin
    optional string background = clearColor;//背景色 ffffff  00ffffff 前两位表示alpha
    optional float borderWidth = 0;//边框宽度
    optional string borderColor = clearColor;//边框颜色
    optional float borderRadius = 0;//边框四个角的圆角半径
    optional CornerLocation borderLocation = 0;//
    optional bool hidden = NO;//可见性 hidden 为YES 时隐藏显示
    optional id dataTag = nil;//数据
    optional string keypath = nil;//key path 路径
    repeated string action = nil;//当action部分有值的时候，给控件添加点击事件
    optional string type = nil;//类名
    optional string identify = nil;//重新标记，没有值，则使用classname
}


message TangramLabel : TangramView {
    optional string text = nil;//文本内容
    optional string textColor = 666666;//字体颜色
    optional float fontSize = 16;//字号大小
    optional TextStyle textStyle = 0;//normal：默认样式，bold：加粗，itlaic：斜体，strike：删除线，underline：下划线
    optional int lines = 1;//固定行数，设为0表示不固定行数
    optional int maxLines = 0;//最大行数，需要配合lines=0使用
    optional LayoutGravity gravity = 0;//描述内容的对齐，比如文字在文本组件里的位置、原子组件在容器里的位置，left：靠左，right：靠右，top：靠上，bottom：靠底，v_center：垂直方向居中，h_center：水平方向居中，可用或组合描述(iOS暂只支持水平方向)
}

message TangramImage : TangramView {
    optional string src = nil;//图片资源，本地资源名或远程图片地址
    optional ScaleType scaleType = 0;//缩放模式(iOS仅支持部分模式，详见代码)
}

message TangramFrameLayout : TangramView {
    repeated TangramView subTangrams = nil;//子控件
}

message TangramVHLayout : TangramFrameLayout {
    optional Orientation orientation = 1;//1:水平布局 2:竖直布局
}

message TangramRatioLayout : TangramFrameLayout {
    optional Orientation orientation = 0;
    optional float layoutRatio = 1;//布局占比
}

message TangramGridLayout : TangramFrameLayout {
    optional int column = 1;//列数
    optional float itemHeight = 0;//元素高度
    optional float itemVerticalMargin = 0;//垂直间距 行之间的距离
    optional float itemHorizontalMargin = 0;//水平间距 列之间的距离
    optional TangramView itemName = nil;//每个Item对应的布局
}















