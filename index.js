/**
 * @Author: jimmydaddy
 * @Date:   2017-07-21 02:31:20
 * @Email:  heyjimmygo@gmail.com
 * @Filename: index.js
 * @Last modified by:   jimmydaddy
 * @Last modified time: 2017-07-24 08:58:48
 * @License: GNU General Public License（GPL)
 * @Copyright: ©2015-2017 www.songxiaocai.com 宋小菜 All Rights Reserved.
 */

 import ReactNative, {NetInfo} from 'react-native';

 const UMPayModule = ReactNative.NativeModules.Umpay;

 module.exports = {
   /**
    * bind
    * @method  bindCard
    * @param   {[type]} data [description]
    * @return  {[type]} [description]
    * @author JimmyDaddy
    * @date    2017-07-24T20:52:39+080
    * @version [version]
    */
   bindCard: (data) => {
     const { identityCode, cardHolder, merCustId, merId, signInfo, cardType, shortBankName, editFlag } = data;
     return UMPayModule.bindCard(identityCode, cardHolder, merCustId, merId, signInfo, cardType, shortBankName, editFlag);
   },

   /**
    * pay
    * @method  pay
    * @param   {[type]} data [description]
    * @return  {[type]} [description]
    * @author JimmyDaddy
    * @date    2017-07-24T20:52:35+080
    * @version [version]
    */
   pay: (data) => {
     const { identityCode, tradeNo, cardHolder, merCustId, cardType, shortBankName, editFlag } = data;
     return UMPayModule.pay(identityCode, tradeNo, cardHolder, merCustId, cardType, shortBankName, editFlag);
   }
 }
