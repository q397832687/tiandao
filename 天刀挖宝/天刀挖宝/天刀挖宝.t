变量 线程ID = 0
var dm,hwnd
//从这里开始执行
功能 执行()
    //从这里开始你的代码
    消息框("这个是热键执行的代码")
结束
//启动_热键操作
功能 启动_热键()
    
    hwnd = dm.FindWindow("","天涯明月刀")
    traceprint("hwnd"&hwnd)
    if(hwnd >0)
        //主窗口绑定
        mainWindowBinding(hwnd)           
    end
    
结束

//终止热键操作
功能 终止_热键()
    如果(线程ID != 0)
        线程关闭(线程ID)
        线程ID = 0        
    结束    
结束

功能 启动_失去焦点()
    //这里添加你要执行的代码
    热键销毁("启动")
    热键注册("启动")
结束


功能 终止_失去焦点()
    //这里添加你要执行的代码
    热键销毁("终止")
    热键注册("终止")
结束


功能 保存配置_点击()
    //这里添加你要执行的代码
    变量 键值 = 0,功能键 = 0
    热键获取键码("启动",键值,功能键)
    文件写配置("热键","启动键值",键值,"D:\\Main.ini")
    文件写配置("热键","启动功能键",功能键,"D:\\Main.ini")
    
    热键获取键码("终止",键值,功能键)
    文件写配置("热键","终止键值",键值,"D:\\Main.ini")
    文件写配置("热键","终止功能键",功能键,"D:\\Main.ini")
结束


功能 天刀挖宝_初始化()
    //这里添加你要执行的代码
    变量 键值 = 0,功能键 = 0
    键值 = 文件读配置("热键","启动键值","D:\\Main.ini")
    功能键 = 文件读配置("热键","启动功能键","D:\\Main.ini")
    如果(键值 != "")
        热键设置键码("启动",键值,功能键)
        热键注册("启动")
    结束
    
    键值 = 文件读配置("热键","终止键值","D:\\Main.ini")
    功能键 = 文件读配置("热键","终止功能键","D:\\Main.ini")
    如果(键值 != "")
        热键设置键码("终止",键值,功能键)
        热键注册("终止")
    结束
    
    变量 提示内容 = "鼠标移动到热键控件里,使得热键控件具有输入焦点,之后输入自己的热键,点击保存配置按钮,那么修改后的热键就会立即生效."
    标签设置文本("标签2",提示内容)
    registerDm()
结束



function registerDm()
    var version
    if(regdll(getrcpath("rc:dm.dll"),true))
        
        
        traceprint("注册大漠插件成功")
        dm = com("dm.dmsoft")
        version =  dm.Ver()
        traceprint("当前大漠插件版本" & version)
    else
        traceprint("大漠插件注册失败")
    end
end






function mainWindowBinding(jb)
    var dm_ret = dm.BindWindow(hwnd,"normal","normal","normal",0)
    dm.SetPath(getrcpath("rc:"))
    traceprint("???????")
    if(dm_ret == 1 )
        traceprint("绑定成功")
        线程ID = threadbegin("startGame","")
    else
        traceprint("绑定失败")
    end
end

function startGame()
    traceprint("????")
    开始挖宝(hwnd)
end



function endGamehotKey_onhotkey()
    if(dm.UnBindWindow() == 1)
        traceprint("窗口解绑成功")
    end
    threadclose(hwnd)
end
