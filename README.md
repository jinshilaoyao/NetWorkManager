# NetWorkManager

访问网络框架<br/>

1.HttpConnect<br/>
  HttpErrorCode: 服务器返回的错误代码枚举<br/>
  NtspHeader: 保存基本信息，主要包括每次向服务器发起请求时，必须传递的参数<br/>
  BaseHttpConnect: 自定义的Session访问网络工具，将获得通讯结果传递给BaseBusiness<br/>
  
2.Business<br/>
  BusinessFactory: 工厂类，根据BusinessType创建BaseBusiness的子类<br/>
  BaseBusiness: 访问网络业务的Business，通过代理直接与BaseHttpConnect相连，为Connect提供URL，<br/>
  BusinessType：业务类型，BusinessFactory以此为标准创建BaseBusiness子类<br/>
  
3.DataModuel<br/>
  BaseDataModule：数据模型<br/>
  DataModuleDelegate：数据模型的代理，delegate一般是Controller，在Controller中实现模型的网络请求的结果（Success，Fail），并执行后续操作。可根据BusinessType判断模型请求的网络服务类型。<br/>


