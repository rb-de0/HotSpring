
public enum RequestResult<T> {
    case success(T)
    case error(Error)
}
