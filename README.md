# 关于
本来要写一个wav录音功能，在github上找到 PLAudio 这个项目。但是我不需要转码部分，所有修改并精简了 源码。

# 致谢
感谢原作者的付出。
 
# 简单说明
由于最终需要集成到UNITY3D，所以我新建并修改了大量内容。请参见 AudioHelper.m 文件。

在CSharp文件内 你只需要使用如下脚本,便可以实现大部分的录音功能

```
	[DllImport("__Internal")]
	private static extern void StartRecording(string p);

	[DllImport("__Internal")]
	private static extern void StopRecording();

	[DllImport("__Internal")]
	private static extern void PauseRecording();

	[DllImport("__Internal")]
	private static extern void ResumeRecording();

	[DllImport("__Internal")]
	private static extern string GetDeviceAudio(string p);

	[DllImport("__Internal")]
	private static extern void DeleteDeviceAudio(string p);

	[DllImport("__Internal")]
	private static extern void StartPlay(string p);

	[DllImport("__Internal")]
	private static extern void StopPlay();

	[DllImport("__Internal")]
	private static extern void PausePlay();

	[DllImport("__Internal")]
	private static extern void ResumePlay();
```