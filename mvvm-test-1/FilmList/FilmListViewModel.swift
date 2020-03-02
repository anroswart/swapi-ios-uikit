import Foundation
import UIKit.UIImage

class FilmListViewModel: NSObject {
    var films: [Film]
    
    init(films: [Film]) {
        self.films = films
    }
    
    func numberOfFilmsToDisplay(in section: Int) -> Int {
        return films.count
    }
    
    func filmToDisplay(at indexPath: IndexPath) -> Film {
        return films[indexPath.row]
    }
}
//2020-03-01 00:21:04.393834+0200 mvvm-test-1[28577:2825818] *** Terminating app due to uncaught exception 'RLMException', reason: 'Realm accessed from incorrect thread.'
//*** First throw call stack:
//(
//    0   CoreFoundation                      0x00007fff23c7127e __exceptionPreprocess + 350
//    1   libobjc.A.dylib                     0x00007fff513fbb20 objc_exception_throw + 48
//    2   Realm                               0x00000001103d9cd3 -[RLMRealm verifyThread] + 131
//    3   Realm                               0x0000000110279f96 _ZL17RLMVerifyAttachedP13RLMObjectBase + 118
//    4   Realm                               0x000000011028036c _ZN12_GLOBAL__N_18getBoxedIN5realm10BinaryDataEEEP11objc_objectP13RLMObjectBasem + 28
//    5   Realm                               0x0000000110280347 ___ZN12_GLOBAL__N_115makeBoxedGetterIN5realm10BinaryDataEEEP11objc_objectm_block_invoke + 39
//    6   mvvm-test-1                         0x000000010fd0d054 $s11mvvm_test_117FilmListViewModelC15posterToDisplay2atSo7UIImageC10Foundation9IndexPathV_tF + 292
//    7   mvvm-test-1                         0x000000010fd23ae6 $s11mvvm_test_122FilmListViewControllerC05tableE0_12cellForRowAtSo07UITableE4CellCSo0lE0C_10Foundation9IndexPathVtF + 1174
//    8   mvvm-test-1                         0x000000010fd23c85 $s11mvvm_test_122FilmListViewControllerC05tableE0_12cellForRowAtSo07UITableE4CellCSo0lE0C_10Foundation9IndexPathVtFTo + 165
//    9   UIKitCore                           0x00007fff48297462 -[UITableView _createPreparedCellForGlobalRow:withIndexPath:willDisplay:] + 781
//    10  UIKitCore                           0x00007fff4826043b -[UITableView _updateVisibleCellsNow:] + 3081
//    11  UIKitCore                           0x00007fff4828055f -[UITableView layoutSubviews] + 194
//    12  UIKitCore                           0x00007fff485784bd -[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 2478
//    13  QuartzCore                          0x00007fff2b131db1 -[CALayer layoutSublayers] + 255
//    14  QuartzCore                          0x00007fff2b137fa3 _ZN2CA5Layer16layout_if_neededEPNS_11TransactionE + 517
//    15  QuartzCore                          0x00007fff2b1438da _ZN2CA5Layer28layout_and_display_if_neededEPNS_11TransactionE + 80
//    16  QuartzCore                          0x00007fff2b08a848 _ZN2CA7Context18commit_transactionEPNS_11TransactionEd + 324
//    17  QuartzCore                          0x00007fff2b0bfb51 _ZN2CA11Transaction6commitEv + 643
//    18  UIKitCore                           0x00007fff480bc3f4 _afterCACommitHandler + 160
//    19  CoreFoundation                      0x00007fff23bd3867 __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__ + 23
//    20  CoreFoundation                      0x00007fff23bce2fe __CFRunLoopDoObservers + 430
//    21  CoreFoundation                      0x00007fff23bce97a __CFRunLoopRun + 1514
//    22  CoreFoundation                      0x00007fff23bce066 CFRunLoopRunSpecific + 438
//    23  GraphicsServices                    0x00007fff384c0bb0 GSEventRunModal + 65
//    24  UIKitCore                           0x00007fff48092d4d UIApplicationMain + 1621
//    25  mvvm-test-1                         0x000000010fd3436b main + 75
//    26  libdyld.dylib                       0x00007fff5227ec25 start + 1
//)
//libc++abi.dylib: terminating with uncaught exception of type NSException
