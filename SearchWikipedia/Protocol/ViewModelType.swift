//
// Created by choimake on 2019-07-05.
//


protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
