## react-native-umpay
*对联动优势提供的sdk进行RN封装*
支持Android、IOS

## 安装配置
* `npm install react-native-umpay`
* `react-native link`
* 根据联动优势给出的文档进行配置
*  Android需要额外配置
 > * 在`android\settings.gradle`中添加(如果上述`link`命令没做到的话)
 ```
 include 'react-native-umpay'
 project(':react-native-umpay').projectDir = new File(rootProject.projectDir, '../   node_modules/react-native-umpay/android')
 ```
  > * 在`android\app\build.gradle`中添加
    `compile project(':react-native-umpay')`
    以及
    `compile 'org.greenrobot:eventbus:3.0.0’`

  > * 在`MainActivity.java`中引入
    `import com.jimmydaddy.umpay.UmpayModule;`
    以及
    `import org.greenrobot.eventbus.EventBus;`

  > * 重写`onActivityResult`如下:
    ```
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == UmpayModule.REQUEST_CODE){
            EventBus.getDefault().post(data);
        }
        super.onActivityResult(requestCode, resultCode, data);
    }
    ```
  > * 在`MainApplication.java`中引入`import com.jimmydaddy.umpay.UmpayPackage;
`添加如下代码
```
  @Override
  protected List<ReactPackage> getPackages() {
    return Arrays.<ReactPackage>asList(
        new MainReactPackage(),
        new UmpayPackage()//添加这个
    );
  }
  ```

## 使用


```
//绑定
/**
 * data 需包含以下字段  { identityCode, cardHolder, merCustId, merId, signInfo, cardType, shortBankName, editFlag };
 * @type {[type]}
 */
UMpay.bindCard(data).then(() => {
  Toast.show('绑定成功');
  this._getData();
}).catch((err) => {
  const errObjStr = JSON.stringify(err);
  const errObj = JSON.parse(errObjStr);
  if (errObj.code === '1001') {
    Toast.show('您取消了操作');
  } else {
    Toast.show('绑定失败');
  }
});

    ....

/**
 * 支付 （支付不建议在客户端操作）
 * data 需包含以下字段   { identityCode, tradeNo, cardHolder, merCustId, cardType, shortBankName, editFlag };
 * @type {[type]}
 */
UMPay.pay(data).then(() => {
  Toast.show('支付成功');
}).catch((err) => {
  const errObjStr = JSON.stringify(err);
  const errObj = JSON.parse(errObjStr);
  if (errObj.code === '1001') {
    Toast.show('您取消了操作');
  } else {
    Toast.show('支付失败');
  }
})
```
